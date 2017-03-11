<%@ page import="br.com.archive.domain.Storage" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'storage.label', default: 'Storage')}" />
        <title><g:message code="menu.index.storage" /></title>
        <r:require module="storage"/>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.index.storage" /></h3>
        </div>
        <table id="storage-table" class="table table-hover tree-table storage-table">
            <thead>
                <tr>
                    <th><g:message code="storage.entity.label" /><div id="searchWrapper"></div></th>
                    <th width="100px">
                        <button type="button" class="add-node btn btn-default">
                            <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span><g:message code="default.button.add.label" />
                        </button>
                    </th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <div class="hidden-form">
            <g:select name="storageType" class="form-control" from="${br.com.archive.domain.StorageType.list()}" optionKey="id" optionValue="name" />
        </div>
    </body>
</html>
