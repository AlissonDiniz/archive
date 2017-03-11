
<%@ page import="br.com.archive.domain.File" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'file.label', default: 'SecUser')}" />
        <title><g:message code="menu.show.file" args="[entityName]" /></title>
        <r:require module="fileShow"/>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.show.file" /></h3>
        </div>
        <ul class="nav nav-pills">
            <li role="presentation">
                <a href="<g:createLink action="search" />">
                    <i class="fa fa-fw fa-plus-circle"></i>
                    <g:message code="command.new.search" />
                </a>
            </li>
        </ul>
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="alert">${flash.message}</div>
        </g:if>
        <div id="show-file" class="content scaffold-show" role="main">
            <ol class="property-list file">
                <li>
                    <p class="text-title"><g:message code="file.code.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${fileInstance}" field="code"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="file.name.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${fileInstance}" field="name"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="classification.entity.label" /></p>
                    <p class="text-primary"><g:link controller="classification" action="show" id="${classificationInstance?.id}">${classificationInstance?.encodeAsHTML()}</g:link></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="storage.entity.label" /></p>
                    <p class="text-primary"><g:link controller="storage" action="show" id="${storageInstance?.id}">${storageInstance?.encodeAsHTML()}</g:link></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="file.subject.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${fileInstance}" field="subject"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="file.type.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${fileInstance}" field="type.name"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="file.tags.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${fileInstance}" field="tagList"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="file.periodInit.label" /></p>
                    <p class="text-primary"><g:formatDate date="${fileInstance?.periodInit}" format="${message (code: "default.date.format")}" /></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="file.periodEnd.label" /></p>
                    <p class="text-primary"><g:formatDate date="${fileInstance?.periodEnd}" format="${message (code: "default.date.format")}" /></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="file.note.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${fileInstance}" field="note"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="default.owner.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${fileInstance}" field="owner"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="default.dateCreated.label" /></p>
                    <p class="text-primary"><g:formatDate date="${fileInstance?.dateCreated}" format="${message (code: "default.datetime.format")}" /></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="default.lastUpdated.label" /></p>
                    <p class="text-primary"><g:formatDate date="${fileInstance?.lastUpdated}" format="${message (code: "default.datetime.format")}" /></p>
                </li>
            </ol>
        </div>
    </body>
</html>
