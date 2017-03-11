<!DOCTYPE html>
<html>
    <head>
        <title><g:message code="file.result-report.label" /></title>
        <r:require module="bootstrap"/>
        <r:require module="resultReport"/>
        <r:layoutResources/>
    </head>
    <body>
        <div class="report-wrapper">
            <div class="header">
                <div class="logo-header">
                    <g:img dir="images" file="maac-logo.jpg" />
                </div>
                <h3><g:message code="file.result-report.label" /></h3>
            </div>
            <div class="parameters">
                <label>
                  <span class="legend"><g:message code="file.report-detail.label" /></span>
                  <span class="text"><g:formatBoolean boolean="${parameters.detail}" /></span>
                </label>
            </div>
            <div class="content">
                <table align="center" class="table" cellpadding="5" cellspacing="0">
                    <thead>
                      <tr>
                        <td width="80px"><g:message code="file.code.label" /></td>
                        <td width="120px"><g:message code="file.subject.label" /></td>
                        <td width="120px"><g:message code="file.type.label" /></td>
                        <td><g:message code="file.name.label" /></td>
                      </tr>
                    </thead>
                    <tbody>
                        <g:each in="${fileListInstance}" status="i" var="fileInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td><strong>${fieldValue(bean: fileInstance, field: "code")}</strong></td>
                                <td>${fieldValue(bean: fileInstance, field: "subject")}</td>
                                <td>${fieldValue(bean: fileInstance, field: "type.name")}</td>
                                <td>${fieldValue(bean: fileInstance, field: "name")}</td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <div class="legend"><g:message code="default.listSize.legend" /> ${fileListInstance.size()}</div>
            </div>
            <div class="footer">
                <div class="footer-right">
                    <sec:username />, <g:formatDate date="${new Date()}" format="${message (code: "default.datetime.format")}" />
                    <br />
                    <span class="print-button glyphicon glyphicon-print" onclick="javascript:window.print()"></span>
                </div>
            </div>
        </div>
    </body>
    <r:layoutResources/>
</html>
