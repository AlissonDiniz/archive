
<%@ page import="br.com.archive.security.SecUser" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'secUser.label', default: 'SecUser')}" />
        <title><g:message code="menu.index.user" /></title>
        <r:require module="secUser"/>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.index.user" /></h3>
        </div>
        <ul class="nav nav-pills">
            <li role="presentation">
                <a href="<g:createLink action="create" />">
                    <i class="fa fa-fw fa-plus-circle"></i>
                    <g:message code="command.new.user" />
                </a>
            </li>
        </ul>
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="alert">${flash.message}</div>
        </g:if>
        <g:render template="/components/quick-search" /> 
        <table class="table table-hover user-table">
            <thead>
                <tr>
                    <g:sortableColumn property="name" title="${message(code: 'secUser.name.label', default: 'Name')}" />
                    <g:sortableColumn property="username" title="${message(code: 'secUser.username.label', default: 'Username')}" />
                    <th><g:message code="secUser.accountExpired.label" /></th>
                    <th><g:message code="secUser.accountLocked.label" /></th>
                    <th><g:message code="default.dateCreated.label" /></th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${secUserInstanceList}" status="i" var="secUserInstance">
                    <tr class="link ${(i % 2) == 0 ? 'even' : 'odd'}" data-path="<g:createLink action="show" id="${secUserInstance.id}"/>">
                        <td>${fieldValue(bean: secUserInstance, field: "name")}</td>
                        <td>${fieldValue(bean: secUserInstance, field: "username")}</td>
                        <td><g:formatBoolean boolean="${secUserInstance.accountExpired}" /></td>
                        <td><g:formatBoolean boolean="${secUserInstance.accountLocked}" /></td>
                        <td><g:formatDate date="${secUserInstance.dateCreated}" format="${message (code: "default.datetime.format")}" /></td>
                    </tr>
                </g:each>
            </tbody>
        </table>
        <div class="pagination">
            <g:paginate total="${secUserInstanceCount ?: 0}" />
        </div>
    </body>
</html>
