
<%@ page import="br.com.archive.domain.FileType" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'fileType.label', default: 'FileType')}" />
        <title><g:message code="menu.index.fileType" /></title>
        <r:require module="fileType"/>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.index.fileType" /></h3>
        </div>
        <ul class="nav nav-pills">
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
        <g:render template="/components/quick-search" />
        <table class="table table-hover fileType-table">
            <thead>
                <tr>
                    <g:sortableColumn property="name" title="${message(code: 'fileType.name.label')}" />
                    <g:sortableColumn property="description" title="${message(code: 'fileType.description.label')}" />
                    <g:sortableColumn property="owner" title="${message(code: 'default.owner.label')}" />
                    <g:sortableColumn property="dateCreated" title="${message(code: 'default.dateCreated.label')}" />
                </tr>
            </thead>
            <tbody>
            <g:each in="${fileTypeInstanceList}" status="i" var="fileTypeInstance">
                <tr class="link ${(i % 2) == 0 ? 'even' : 'odd'}" data-path="<g:createLink action="show" id="${fileTypeInstance.id}"/>">
                    <td>${fieldValue(bean: fileTypeInstance, field: "name")}</td>
                    <td>${fieldValue(bean: fileTypeInstance, field: "description")}</td>
                    <td>${fieldValue(bean: fileTypeInstance, field: "owner")}</td>
                    <td><g:formatDate date="${fileTypeInstance.dateCreated}" format="${message (code: "default.datetime.format")}" /></td>
                </tr>
            </g:each>
            </tbody>
        </table>
        <div class="pagination">
            <g:paginate total="${fileTypeInstanceCount ?: 0}" />
        </div>
    </body>
</html>
