<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'file.label', default: 'Storage')}" />
        <title><g:message code="menu.search.file" args="[entityName]" /></title>
        <r:require module="search"/>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.search.file" /></h3>
        </div>
        <g:form name="form" action="resultSearch" role="form">
            <fieldset class="form form-search">
                <div class="col-xs-8 form-group">
                    <label for="code">
                        <g:message code="file.code.label" />
                    </label>
                    <g:textField name="code" class="form-control" placeholder="${message (code: "file.code.label")}" />
                </div>
                <div class="col-xs-8 form-group">
                    <label for="name">
                        <g:message code="file.name.label" />
                    </label>
                    <g:textField name="name" class="form-control" placeholder="${message (code: "file.name.label")}" />
                </div>
                <div class="col-xs-8 form-group">
                    <label for="subject">
                        <g:message code="file.subject.label" />
                    </label>
                    <g:textField name="subject" class="form-control" placeholder="${message (code: "file.subject.label")}" />
                </div>
                <div class="col-xs-8 form-group">
                    <label for="tags">
                        <g:message code="file.tags.label" />
                    </label>
                    <g:textField name="tags" class="form-control" placeholder="${message (code: "file.tags.label")}" />
                </div>
                <div class="col-xs-8 form-group">
                    <label for="type">
                        <g:message code="file.type.label" />
                    </label>
                    <g:select name="type" class="form-control" from="${br.com.archive.domain.FileType.list()}" optionKey="id" optionValue="name" noSelection="${['': g.message(code: "default.field.all")]}" />
                </div>
                <div class="col-xs-8 form-group">
                    <label for="note">
                        <g:message code="file.note.label" />
                    </label>
                    <g:textField name="note" class="form-control" placeholder="${message (code: "file.note.label")}" />
                </div>
                <div class="col-xs-8 form-group container-date">
                    <div class="col-xs-6 form-group">
                        <label for="periodInit">
                            <g:message code="file.periodInit.label" />
                        </label>
                        <g:textField name="periodInit" class="mask-date date-picker form-control" placeholder="${message (code: "file.periodInit.label")}" />
                    </div>
                    <div class="col-xs-6 form-group">
                        <label for="periodEnd">
                            <g:message code="file.periodEnd.label" />
                        </label>
                        <g:textField name="periodEnd" class="mask-date date-picker form-control" placeholder="${message (code: "file.periodEnd.label")}" />
                    </div>
                </div>
                <div class="col-xs-12 form-group buttons">
                    <button type="submit" data-form="form" class="btn btn-default">
                        <span class="glyphicon glyphicon-zoom-in" aria-hidden="true"></span> <g:message code="default.button.search.label" />
                    </button>
                </div>
            </fieldset>
        </g:form>
    </body>
</html>
