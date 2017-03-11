
<%@ page import="br.com.archive.domain.StorageType" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'fileType.label', default: 'StorageType')}" />
        <title><g:message code="menu.show.fileType" /></title>
        <r:require module="fileType"/>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.show.fileType" /></h3>
        </div>
        <ul class="nav nav-pills">
            <li role="presentation">
                <a href="<g:createLink action="index" />">
                    <i class="fa fa-fw fa-tasks"></i>
                    <g:message code="command.index.fileType" />
                </a>
            </li>
            <li role="presentation">
                <a href="<g:createLink action="create" />">
                    <i class="fa fa-fw fa-plus-circle"></i>
                    <g:message code="command.new.fileType" />
                </a>
            </li>
        </ul>
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="alert">${flash.message}</div>
        </g:if>
        <div id="show-fileType" class="content scaffold-show" role="main">
            <ol class="property-list fileType">
                <li class="fieldcontain">
                    <p class="text-title"><g:message code="fileType.name.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${fileTypeInstance}" field="name"/></p>
                </li>
                <li class="fieldcontain">
                    <p class="text-title"><g:message code="fileType.description.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${fileTypeInstance}" field="description"/></p>
                </li>
                <li class="fieldcontain">
                    <p class="text-title"><g:message code="default.owner.label" /></p>
                    <p class="text-primary"><g:fieldValue bean="${fileTypeInstance}" field="owner"/></p>
                </li>
                <li class="fieldcontain">
                    <p class="text-title"><g:message code="default.dateCreated.label" /></p>
                    <p class="text-primary"><g:formatDate date="${fileTypeInstance?.dateCreated}" format="${message (code: "default.datetime.format")}" /></p>
                </li>
                <li class="fieldcontain">
                    <p class="text-title"><g:message code="default.lastUpdated.label" /></p>
                    <p class="text-primary"><g:formatDate date="${fileTypeInstance?.lastUpdated}" format="${message (code: "default.datetime.format")}" /></p>
                </li>
            </ol>
            <div class="col-xs-12 form-group buttons">
                <button type="button" data-path="<g:createLink action="edit" resource="${fileTypeInstance}" />" class="btn btn-default redirect">
                    <span class="glyphicon glyphicon-edit" aria-hidden="true"></span> <g:message code="default.button.edit.label" />
                </button>
            </div>
        </div>
    </body>
</html>
