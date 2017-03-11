<%@ page import="br.com.archive.domain.Classification" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'classification.label', default: 'Classification')}" />
        <title><g:message code="menu.index.classification" /></title>
        <r:require module="classification"/>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.index.classification" /></h3>
        </div>
        <table id="tree-classification" class="table table-hover tree-table classification-table">
            <thead>
                <tr>
                    <th><g:message code="classification.entity.label" /><div id="searchWrapper"></div></th>
                    <th width="100px">
                        <button type="button" class="add-node btn btn-default">
                            <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span> <g:message code="default.button.add.label" />
                        </button>
                    </th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </body>
</html>
