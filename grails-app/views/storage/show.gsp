
<%@ page import="br.com.archive.domain.Storage" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'storage.label', default: 'Storage')}" />
        <title><g:message code="menu.show.storage" args="[entityName]" /></title>
        <r:require module="storageShow"/>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.show.storage" /></h3>
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
        <div id="show-storage" class="content scaffold-show" role="main">
            <ol class="property-list storage">
                <li>
                    <p class="text-title"><g:message code="storage.parentStorage.label" /></p>
                    <p class="text-primary"><g:link controller="storage" action="show" id="${storageInstance.parentStorage?.id}">${storageInstance.parentStorage?.encodeAsHTML()}</g:link></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="storage.code.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${storageInstance}" field="code"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="storage.name.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${storageInstance}" field="name"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="storage.type.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${storageInstance}" field="type.name"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="default.owner.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${storageInstance}" field="owner"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="default.dateCreated.label" /></p>
                    <p class="text-primary"><g:formatDate date="${storageInstance?.dateCreated}" format="${message (code: "default.datetime.format")}" /></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="default.lastUpdated.label" /></p>
                    <p class="text-primary"><g:formatDate date="${storageInstance?.lastUpdated}" format="${message (code: "default.datetime.format")}" /></p>
                </li>
            </ol>
        </div>
    </body>
</html>
