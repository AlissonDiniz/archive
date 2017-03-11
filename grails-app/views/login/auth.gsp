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
        <title><g:message code="springSecurity.login.title"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.png')}" type="image/x-icon">
        <r:require module="bootstrap"/>
        <r:require module="auth"/>
        <r:layoutResources/>
    </head>
    <body id="body-container">
        <div id="login-wrapper" class="login-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xs-12">
                        <div id="loginbox" style="margin-top: 10%;" class="mainbox">                    
                            <div class="panel" >
                                <div class="panel-heading">
                                    <div class="panel-title">MAAC - MUSEU DE ARTE ASSIS CHATEAUBRIAND</div>
                                </div>     
                                <div style="padding: 50px 20px 50px 20px" class="panel-body" >
                                    <form id='form' role="form" action='${postUrl}' method='POST' autocomplete='off'>
                                        <div class="col-xs-12 form-group">
                                            <div class="input-group">
                                                <label for="username" class="login-data input-group-addon glyphicon glyphicon-user"></label>
                                                <input type="text" class="form-control" id='username' name='j_username' required placeholder="<g:message code="login.user.label" />" maxlength="20" />
                                            </div>
                                        </div> 
                                        <div class="col-xs-12 form-group">
                                            <div class="input-group">
                                                <label for="password" class="login-data input-group-addon glyphicon glyphicon-lock"></label>
                                                <input type="password" class="form-control" id="password" name="j_password" required placeholder="<g:message code="login.password.label" />" maxlength="40" />
                                            </div>
                                        </div>
                                        <div class="col-xs-12">
                                            <input style="float: left;" type='checkbox' class='chk checkbox' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                                                <label for='remember_me' style="width: 100px; margin: 0 0 15px 10px; font-weight: normal"><g:message code="login.remember" /></label>
                                        </div>
                                        <div class="col-xs-12">
                                            <button class="form-control btn btn-primary btn-md" type="submit" title="<g:message code="login.button.title" />"><g:message code="login.button.label" /></button>
                                        </div>
                                        <div class="container-message col-xs-12">
                                            <g:if test='${flash.message}'>
                                                <div class="alert alert-danger" role="alert">${flash.message}</div>
                                            </g:if>
                                        </div>
                                    </form>   
                                </div>                     
                            </div>  
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <r:layoutResources/>
</html>
