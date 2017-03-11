<!DOCTYPE html>
<html>
    <head>
        <title><g:message code="classification.result-report.label" /></title>
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
                <h3><g:message code="classification.result-report.label" /></h3>
            </div>
            <div class="parameters">
                <label>
                  <span class="legend"><g:message code="classification.report-type.label" /></span>
                  <span class="text">${parameters.typeReport}</span>
                </label>
                <label>
                  <span class="legend"><g:message code="classification.report-detail.label" /></span>
                  <span class="text"><g:formatBoolean boolean="${parameters.detail}" /></span>
                </label>
            </div>
            <div class="content">
                <table align="center" class="table" cellpadding="5" cellspacing="0">
                    <thead>
                      <tr>
                        <td width="80px"><g:message code="classification.code.label" /></td>
                        <td><g:message code="classification.name.label" /></td>
                        <td width="100px" class="center"><g:message code="default.owner.label" /></td>
                        <td width="120px" class="center"><g:message code="default.dateCreated.label" /></td>
                      </tr>
                    </thead>
                    <tbody>
                        <g:each in="${classificationInstanceTree}" status="i" var="classificationNode">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td><strong>${fieldValue(bean: classificationNode, field: "code")}</strong></td>
                                <td>${fieldValue(bean: classificationNode, field: "name")}</td>
                                <td class="center">${fieldValue(bean: classificationNode, field: "owner")}</td>
                                <td class="center small"><g:formatDate date="${classificationNode.dateCreated}" format="${message (code: "default.datetime.format")}" /></td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <div class="legend"><g:message code="default.listSize.legend" /> ${classificationInstanceTree.size()}</div>
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
