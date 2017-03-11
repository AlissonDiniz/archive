
<%@ page import="br.com.archive.domain.File" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'file.label', default: 'File')}" />
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
        <table class="table table-hover file-table">
            <thead>
                <tr>
                    <th class="column-code"><g:message code="file.code.label" /></th>
                    <th class="column-classification"><g:message code="classification.entity.label" /></th>
                    <th class="column-subject"><g:message code="file.subject.label" /></th>
                    <th class="column-type"><g:message code="file.type.label" /></th>
                    <th><g:message code="file.name.label" /></th>
                    <th class="column-default"><g:message code="default.owner.label" /></th>
                    <th class="column-default"><g:message code="default.dateCreated.label" /></th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${fileInstanceList}" status="i" var="fileInstance">
                    <tr class="link ${(i % 2) == 0 ? 'even' : 'odd'}" data-path="<g:createLink action="show" id="${fileInstance.id}"/>">
                        <td class="column-code">${fieldValue(bean: fileInstance, field: "code")}</td>
                        <td class="column-classification">${fieldValue(bean: fileInstance, field: "parentClassification.code")} - ${fieldValue(bean: fileInstance, field: "parentClassification.name")}</td>
                        <td class="column-subject">${fieldValue(bean: fileInstance, field: "subject")}</td>
                        <td class="column-type">${fieldValue(bean: fileInstance, field: "type.name")}</td>
                        <td>${fieldValue(bean: fileInstance, field: "name")}</td>
                        <td class="column-default">${fieldValue(bean: fileInstance, field: "owner")}</td>
                        <td class="column-default"><g:formatDate date="${fileInstance.dateCreated}" /></td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </body>
</html>
