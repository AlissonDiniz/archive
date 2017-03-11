
<%@ page import="br.com.archive.domain.Classification" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'classification.label', default: 'Classification')}" />
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
        <table class="table table-hover classification-table">
            <thead>
                <tr>
                    <th class="column-code"><g:message code="classification.code.label" /></th>
                    <th><g:message code="classification.name.label" /></th>
                    <th class="column-default"><g:message code="default.owner.label" /></th>
                    <th class="column-default"><g:message code="default.dateCreated.label" /></th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${classificationInstanceList}" status="i" var="classificationInstance">
                    <tr class="link ${(i % 2) == 0 ? 'even' : 'odd'}" data-path="<g:createLink action="show" id="${classificationInstance.id}"/>">
                        <td class="column-code">${fieldValue(bean: classificationInstance, field: "code")}</td>
                        <td>${fieldValue(bean: classificationInstance, field: "name")}</td>
                        <td class="column-default">${fieldValue(bean: classificationInstance, field: "owner")}</td>
                        <td class="column-default"><g:formatDate date="${classificationInstance.dateCreated}" /></td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </body>
</html>
