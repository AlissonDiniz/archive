
<%@ page import="br.com.archive.domain.File" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'file.label', default: 'File')}" />
        <title><g:message code="menu.index.file" /></title>
        <r:require module="file"/>
    </head>
    <body>
        <div id="legend-page" class="legend-page">
            <h3><g:message code="menu.index.file" /></h3>
        </div>
        <div id="wrapperFileList" class="wrapper-file-list col-xs-12">
            <div id="storagePlant" class="storage-plant col-xs-4">
                <table id="tree-storage" class="table table-hover tree-table storage-table">
                    <thead>
                        <tr>
                            <th><g:message code="storage.entity.label" /><div id="searchWrapperStorage"></div></th>                
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div id="fileList" class="file-list col-xs-8 disabled">
                <div class="col-xs-12">
                    <div id="search-file" class="search-wrapper custom-search col-xs-10 form-group search-file">
                        <g:field type="text" name="search-field" class="form-control" placeholder="${message (code: "default.quick-search.label")}" />
                        <span class="glyphicon placeholder-button glyphicon-search form-control-feedback" aria-hidden="true"></span>
                        <span class="glyphicon clean-button glyphicon-remove-sign form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <div id="add-file" class="add-file col-xs-2">
                        <button type="button" class="btn btn-default">
                            <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span> <g:message code="default.button.add.label" />
                        </button>
                    </div>
                </div>
                <table id="file-table" class="table table-hover file-table">
                    <thead class="override">
                        <tr>
                            <th><g:message code="file.code.label" /></th>
                            <th><g:message code="file.name.label" /></th>
                            <th><g:message code="file.subject.label" /></th>
                            <th class="type"><g:message code="file.type.label" /></th>
                            <th><g:message code="file.period.label" /></th>
                            <th><g:message code="file.tags.label" /></th>
                            <th colspan="2"><g:message code="file.note.label" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                <div id="fileListOverlay" class="file-list-overlay"></div>
            </div>
        </div>
        <div id="addFileModal" class="add-file-modal">
            <h3><g:message code="file.add.modal.title" /></h3>
            <div class="classification-container">
                <div class="classification-table-wrapper">
                    <table id="treeClassification" class="table table-hover tree-table classification-table">
                        <thead>
                            <tr>
                                <th><g:message code="classification.entity.label" /><div id="searchWrapperClassification"></div></th>                
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <div class="col-xs-12 buttons">
                    <button type="button" class="btn btn-default next-button" disabled="disabled">
                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> <g:message code="default.paginate.next" />
                    </button>
                    <button type="button" class="btn btn-warning cancel-button">
                        <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span> <g:message code="default.button.cancel.label" />
                    </button>
                </div>
            </div>
            <div class="file-container">
                <div class="file-table-wrapper">
                    <fieldset class="form">
                        <div class="col-xs-8">
                            <div class="col-xs-4 form-group code-input">
                                <label for="code">
                                    <g:message code="file.code.label" />
                                    <span class="required-indicator">*</span>
                                </label>
                                <g:textField name="code" class="validate required form-control" disabled="disabled" placeholder="${message (code: "file.code.label")}" />
                                <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" aria-hidden="true"></span>
                            </div>
                        </div>
                        <div class="col-xs-8 form-group">
                            <label for="name">
                                <g:message code="file.name.label" />
                                <span class="required-indicator">*</span>
                            </label>
                            <g:textField name="name" class="validate required form-control" placeholder="${message (code: "file.name.label")}" />
                            <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" aria-hidden="true"></span>
                        </div>
                        <div class="col-xs-8 period">
                            <div class="col-xs-6 form-group">
                                <label for="periodInit">
                                    <g:message code="file.periodInit.label" />
                                </label>
                                <g:textField name="periodInit" class="date-picker form-control" placeholder="${message (code: "file.periodInit.label")}" />
                            </div>
                            <div class="col-xs-6 form-group">
                                <label for="periodEnd">
                                    <g:message code="file.periodEnd.label" />
                                </label>
                                <g:textField name="periodEnd" class="date-picker form-control" placeholder="${message (code: "file.periodEnd.label")}" />
                            </div>
                        </div>
                        <div class="col-xs-8 form-group">
                            <label for="tags">
                                <g:message code="file.tags.label" />
                            </label>
                            <g:textField name="tags" class="form-control" placeholder="${message (code: "file.tags.label")}" />
                        </div>
                        <div class="col-xs-8 form-group">
                            <label for="subject">
                                <g:message code="file.subject.label" />
                            </label>
                            <g:textField name="subject" class="form-control" placeholder="${message (code: "file.subject.label")}" />
                        </div>
                        <div class="col-xs-8 form-group">
                            <label for="type">
                                <g:message code="file.type.label" />
                            </label>
                            <g:select name="type" class="form-control" from="${br.com.archive.domain.FileType.list()}" optionKey="id" optionValue="name" />
                        </div>
                        <div class="col-xs-8 form-group">
                            <label for="note">
                                <g:message code="file.note.label" />
                            </label>
                            <g:textArea name="note" class="form-control" rows="5" cols="40"/>
                        </div>
                    </fieldset>
                </div>
                <div class="col-xs-12 buttons">
                    <button type="button" class="btn btn-default save-button">
                        <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span> <g:message code="default.button.save.label" />
                    </button>
                    <button type="button" class="btn btn-warning previous-button">
                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> <g:message code="default.paginate.prev" />
                    </button>
                </div>
            </div>
        </div>
        <div id="editFileModal" class="edit-file-modal" data-file-id="">
            <h3><g:message code="file.edit.modal.title" /></h3>
            <div class="file-container">
                <div class="file-table-wrapper">
                    <fieldset class="form">
                        <div class="col-xs-8">
                            <div class="col-xs-4 form-group code-input">
                                <label for="code">
                                    <g:message code="file.code.label" />
                                    <span class="required-indicator">*</span>
                                </label>
                                <g:textField name="code" class="validate required form-control" disabled="disabled" placeholder="${message (code: "file.code.label")}" />
                                <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" aria-hidden="true"></span>
                            </div>
                        </div>
                        <div class="col-xs-8 form-group">
                            <label for="name">
                                <g:message code="file.name.label" />
                                <span class="required-indicator">*</span>
                            </label>
                            <g:textField name="name" class="validate required form-control" placeholder="${message (code: "file.name.label")}" />
                            <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" aria-hidden="true"></span>
                        </div>
                        <div class="col-xs-8 period">
                            <div class="col-xs-6 form-group">
                                <label for="periodInitEdit">
                                    <g:message code="file.periodInit.label" />
                                </label>
                                <g:textField name="periodInitEdit" class="mask-date date-picker form-control" placeholder="${message (code: "file.periodInit.label")}" />
                            </div>
                            <div class="col-xs-6 form-group">
                                <label for="periodEndEdit">
                                    <g:message code="file.periodEnd.label" />
                                </label>
                                <g:textField name="periodEndEdit" class="mask-date date-picker form-control" placeholder="${message (code: "file.periodEnd.label")}" />
                            </div>
                        </div>
                        <div class="col-xs-8 form-group">
                            <label for="tags">
                                <g:message code="file.tags.label" />
                            </label>
                            <div id="container-tags"></div>
                        </div>
                        <div class="col-xs-8 form-group">
                            <label for="subject">
                                <g:message code="file.subject.label" />
                            </label>
                            <g:textField name="subject" class="form-control" placeholder="${message (code: "file.subject.label")}" />
                        </div>
                        <div class="col-xs-8 form-group">
                            <label for="type">
                                <g:message code="file.type.label" />
                            </label>
                            <g:select name="type" class="form-control" from="${br.com.archive.domain.FileType.list()}" optionKey="id" optionValue="name" />
                        </div>
                        <div class="col-xs-8 form-group">
                            <label for="note">
                                <g:message code="file.note.label" />
                            </label>
                            <g:textArea name="note" class="form-control" rows="5" cols="40"/>
                        </div>
                    </fieldset>
                </div>
                <div class="col-xs-12 buttons">
                    <button type="button" class="btn btn-default save-button">
                        <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span> <g:message code="default.button.save.label" />
                    </button>
                    <button type="button" class="btn btn-warning cancel-button">
                        <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span> <g:message code="default.button.cancel.label" />
                    </button>
                </div>
            </div>
        </div>
    </body>
</html>
