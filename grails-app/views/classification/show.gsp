
<%@ page import="br.com.archive.domain.Classification" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'classification.label', default: 'SecUser')}" />
        <title><g:message code="menu.show.classification" args="[entityName]" /></title>
        <r:require module="classificationShow"/>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.show.classification" /></h3>
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
        <div id="show-classification" class="content scaffold-show" role="main">
            <ol class="property-list classification">
                <li>
                    <p class="text-title"><g:message code="classification.parentClassification.label" /></p>
                    <p class="text-primary"><g:link controller="classification" action="show" id="${classificationInstance.parentClassification?.id}">${classificationInstance.parentClassification?.encodeAsHTML()}</g:link></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="classification.code.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${classificationInstance}" field="code"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="classification.name.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${classificationInstance}" field="name"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="default.owner.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${classificationInstance}" field="owner"/></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="default.dateCreated.label" /></p>
                    <p class="text-primary"><g:formatDate date="${classificationInstance?.dateCreated}" format="${message (code: "default.datetime.format")}" /></p>
                </li>
                <li>
                    <p class="text-title"><g:message code="default.lastUpdated.label" /></p>
                    <p class="text-primary"><g:formatDate date="${classificationInstance?.lastUpdated}" format="${message (code: "default.datetime.format")}" /></p>
                </li>
            </ol>
        </div>
    </body>
</html>
