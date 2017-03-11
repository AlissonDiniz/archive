
<%@ page import="br.com.archive.domain.StorageType" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'storageType.label', default: 'StorageType')}" />
        <title><g:message code="menu.show.storageType" /></title>
        <r:require module="storageType"/>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.show.storageType" /></h3>
        </div>
        <ul class="nav nav-pills">
            <li role="presentation">
                <a href="<g:createLink action="index" />">
                    <i class="fa fa-fw fa-tasks"></i>
                    <g:message code="command.index.storageType" />
                </a>
            </li>
            <li role="presentation">
                <a href="<g:createLink action="create" />">
                    <i class="fa fa-fw fa-plus-circle"></i>
                    <g:message code="command.new.storageType" />
                </a>
            </li>
        </ul>
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="alert">${flash.message}</div>
        </g:if>
        <div id="show-storageType" class="content scaffold-show" role="main">
            <ol class="property-list storageType">
                <li class="fieldcontain">
                    <p class="text-title"><g:message code="storageType.name.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${storageTypeInstance}" field="name"/></p>
                </li>
                <li class="fieldcontain">
                    <p class="text-title"><g:message code="storageType.description.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${storageTypeInstance}" field="description"/></p>
                </li>
                <li class="fieldcontain">
                    <p class="text-title"><g:message code="default.owner.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${storageTypeInstance}" field="owner"/></p>
                </li>
                <li class="fieldcontain">
                    <p class="text-title"><g:message code="default.dateCreated.label" /></p>
                    <p class="text-primary"><g:formatDate date="${storageTypeInstance?.dateCreated}" format="${message (code: "default.datetime.format")}" /></p>
                </li>
                <li class="fieldcontain">
                    <p class="text-title"><g:message code="default.lastUpdated.label" /></p>
                    <p class="text-primary"><g:formatDate date="${storageTypeInstance?.lastUpdated}" format="${message (code: "default.datetime.format")}" /></p>
                </li>
            </ol>
            <div class="col-xs-12 form-group buttons">
                <button type="button" data-path="<g:createLink action="edit" resource="${storageTypeInstance}" />" class="btn btn-default redirect">
                    <span class="glyphicon glyphicon-edit" aria-hidden="true"></span> <g:message code="default.button.edit.label" />
                </button>
            </div>
        </div>
    </body>
</html>
