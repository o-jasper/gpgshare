// ==UserScript==
// @name                comment-anywhere
// @namespace	        comment-anywhere
// @description	        developping system to comment anywhere.(GPL)
// @include		*
// @grant               GM_getValue
// ==/UserScript==

//
//  Copyright (C) 02-10-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//---- Keeping track where the mouse is over.(keyboard events dont tell this)
/*var mouse_over = null;
document.onmouseover = function (ev)
{   if (!ev){ return; }
    mouse_over = ev.target;
}*/

var all_source = "http://192.168.1.100:3000/";
var comments_source = all_source + "comments_of/";

var from_groups=[]; //Groups to ask for comments from.
var rated = -1;     //Rating of the comment.
var max_n=100;      //Max number of comments fetched.

function assert(condition, message) 
{   if (!condition) { throw message || "Assertion failed"; } }

function add_comments(list, commentor)
{   for( var i = 1 ; i<list.length ; i++ )
    {   var name = list[i].getAttribute('name');
        if( name==null ){ name = list[i].getAttribute('id'); }
        if( name==null ){ commentor(list[i],name); }
    }
}


var comment_take_fraction = 20;

//--- Makes space and allows placing of <div> elements to the right.
var side_div_active = false;
//TODO pick sides, add way to add to the bottom.
function ensure_side_div_active()
{   if( side_div_active ){ return; }
    document.body.innerHTML = '<table><tr><td>' + document.body.innerHTML + 
          '</td><td style="width:' + comment_take_fraction + 
    '%;"></td></tr></table>';
    side_div_active=true;
}

var div_extra_space = 5; //TODO not resize-tolerant.
var last_div_ty = 0; //Max y(lowest point) of previous div.
function side_div_near(near, content)
{   ensure_side_div_active();
    var rect = near.getBoundingClientRect();
    var add = document.createElement('div');
    add.style.position = 'absolute';
//    add.style.border = '1px solid red';
    var to_y = rect.top;
    if( to_y < last_div_ty ){ to_y =last_div_ty; }
    add.style.top = to_y + 'px';
    add.style.left = (100-comment_take_fraction) + '%';
    add.innerHTML = content;
    document.body.appendChild(add);
    //Note that that value only gets defined after adding/drawing, at least in 
    // midori.
    last_div_ty = add.getBoundingClientRect().bottom + div_extra_space;
//   	document.body.outerHTML += 
//            '<div style="position:absolute;top:' +rect.top +
//            'px;left:'+(100-comment_take_fraction)+'%;width:'+
//             comment_take_fraction+'%;border:1px solid red;">'+ 
//             content+ '</div>';
}

//---
function dumb_commentor(of, name)
{  
    side_div_near(of, "a b c d e f g h i j k l m n o p q r s t u v w x y z 1 2 3 4 5 6 7 8 9 0");
//    of.outerHTML += '<div style="position:absolute;left:200px;">stuff</div>';
}

function link_of(name)
{   return document.url + "#" + name; }

//Might not want to get the data one by one.
function fetching_commentor(of,name) 
{   GM_xmlhttpRequest({
        method:"GET", url:(comments_source + link_of(name)),
        data: "comments " + from_groups + " " + rated + " " + max_n,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        onload: function(response)
        {    div_element(of,response);
        }});
}

var did_it = false;

document.body.onclick = function(ev)
{   if( !did_it ) 
    {   add_comments(document.getElementsByTagName('a'), dumb_commentor);
        did_it = true;
    }
}
//add_comments(document.getElementsByTagName('span'), dumb_commentor);
