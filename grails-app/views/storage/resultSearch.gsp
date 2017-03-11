
<%@ page import="br.com.archive.domain.Storage" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'storage.label', default: 'Storage')}" />
        <title><g:message code="menu.search.result" /></title>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.search.result" /></h3>
        </div>
        <ul class="nav nav-pills margin-table">
            <li role="presentation">
                <a href="<g:createLink action="search" />">
                    <i class="fa fa-fw fa-search"></i>
                    <g:message code="command.new.search" />
                </a>
            </li>
        </ul>
        <table class="table table-hover storage-table">
            <thead>
                <tr>
                    <th class="column-code"><g:message code="storage.code.label" /></th>
                    <th class="column-type"><g:message code="storage.type.label" /></th>
                    <th><g:message code="storage.name.label" /></th>
                    <th class="column-default"><g:message code="default.owner.label" /></th>
                    <th class="column-default"><g:message code="default.dateCreated.label" /></th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${storageInstanceList}" status="i" var="storageInstance">
                    <tr class="link ${(i % 2) == 0 ? 'even' : 'odd'}" data-path="<g:createLink action="show" id="${storageInstance.id}"/>">
                        <td class="column-code">${fieldValue(bean: storageInstance, field: "code")}</td>
                        <td class="column-type">${fieldValue(bean: storageInstance, field: "type.name")}</td>
                        <td>${fieldValue(bean: storageInstance, field: "name")}</td>
                        <td class="column-default">${fieldValue(bean: storageInstance, field: "owner")}</td>
                        <td class="column-default"><g:formatDate date="${storageInstance.dateCreated}" /></td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </body>
</html>
