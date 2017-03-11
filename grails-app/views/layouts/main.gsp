<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
            <title><g:layoutTitle default="Archive System"/></title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <script src="<g:createLink action="index" controller="i18n" />"></script>
            <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.png')}" type="image/x-icon">
        <r:require module="application"/>
        <r:layoutResources/>
    </head>
    <body>
        <div id="wrapper">
            <div class="container-fluid">
                <div class="navbar">
                    <g:render template="/layouts/navbar" /> 
                </div>
                <div class="sidebar">
                    <g:render template="/layouts/sidebar" /> 
                </div>
                <div class="body">
                    <div class="row">
                        <div class="main-wrapper">
                            <g:layoutBody/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <p>© Desenvolvido por <a href="http://about.me/alissondiniz" target="_blank">Alisson Diniz</a></p>
        </footer>
        <div id="dialog-message" class="dialog" title="<g:message code="default.system.message" />"></div>
        <div id="dialog-changePassword" class="dialog">
            <h3><g:message code="secUser.button.editPassword.label" /></h3>
            <fieldset class="form form-changePassword">
                <div class="col-xs-12 form-group code-input">
                    <label for="oldPassword">
                        <g:message code="secUser.oldPassword.label" />
                        <span class="required-indicator">*</span>
                    </label>
                    <g:field type="password" name="oldPassword" class="validate required form-control" placeholder="${message (code: "secUser.oldPassword.label")}" />
                    <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" aria-hidden="true"></span>
                </div>
                <div class="col-xs-12 form-group code-input">
                    <label for="newPassword">
                        <g:message code="secUser.newPassword.label" />
                        <span class="required-indicator">*</span>
                    </label>
                    <g:field type="password" name="newPassword" class="validate required form-control" placeholder="${message (code: "secUser.newPassword.label")}" />
                    <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" aria-hidden="true"></span>
                </div>
                <div class="col-xs-12 form-group code-input">
                    <label for="confirmPassword">
                        <g:message code="secUser.confirmPassword.label" />
                        <span class="required-indicator">*</span>
                    </label>
                    <g:field type="password" name="confirmPassword" class="validate confirm form-control" data-field="newPassword" placeholder="${message (code: "secUser.confirmPassword.label")}" />
                    <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" data-message-confirm="${message (code: "default.field.confirm")}" aria-hidden="true"></span>
                </div>
                <div class="col-xs-12 buttons">
                    <button type="button" class="btn btn-warning cancel-button">
                        <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span> <g:message code="default.button.cancel.label" />
                    </button>
                    <button type="button" class="btn btn-default save-button">
                        <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span> <g:message code="default.button.save.label" />
                    </button>
                </div>
            </fieldset>
        </div>
        <div id="dialog-wait" class="dialog">
            <div class="wait-container">
                <g:message code="default.system.wait" />
            </div>
        </div>
    </body>
    <r:layoutResources/>
</html>