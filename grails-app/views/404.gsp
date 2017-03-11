<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <title><g:message code="default.page.notfound" /></title>
        <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.png')}" type="image/x-icon" />
        <r:require module="error"/>
    </head>
    <body>
        <div id="wrapper">
            <div id="header">
                <g:img dir="images" file="maac-logo.jpg" />
                <span>MAAC - Arquivo</span>
            </div>
            <div id='boxError'>
                <img src="${resource(dir:'images',file:'ops.png')}" />
                <h1><g:message code="default.page.notfound" /><br/><br/></h1>
            </div>
        </div>
    </body>
    <r:layoutResources/>
</html>
