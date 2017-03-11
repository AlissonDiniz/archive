package br.com.archive.helper

class I18nController {

    def index() {
        def messages = "DEFAULT_DATE_FORMAT: '" + message(code: 'default.date.format') + "'";
        messages = messages + ", " + "DEFAULT_DATE_FORMAT_INPUT: '" + message(code: 'default.date.format.input') + "'";
        messages = messages + ", " + "DEFAULT_UNDATED_LABEL: '" + message(code: 'default.undated.label') + "'";
        messages = messages + ", " + "DEFAULT_BOOLEAN_TRUE: '" + message(code: 'default.boolean.true') + "'";
        messages = messages + ", " + "DEFAULT_BOOLEAN_FALSE: '" + message(code: 'default.boolean.false') + "'";
        messages = messages + ", " + "DEFAULT_SYSTEM_DENIED: '" + message(code: 'default.system.denied') + "'";
        messages = messages + ", " + "DEFAULT_SYSTEM_ERROR: '" + message(code: 'default.system.error') + "'";
        messages = messages + ", " + "DEFAULT_BUTTON_CANCEL_LABEL: '" + message(code: 'default.button.cancel.label') + "'";
        messages = messages + ", " + "DEFAULT_CODE_UNIQUE: '" + message(code: 'default.code.unique') + "'";
        messages = messages + ", " + "DEFAULT_FIELD_REQUIRED: '" + message(code: 'default.field.required') + "'";
        messages = messages + ", " + "DEFAULT_QUICKSEARCH_LABEL: '" + message(code: 'default.quick-search.label') + "'";
        messages = messages + ", " + "SECUSER_OLDPASSWORD_INVALID: '" + message(code: 'secUser.oldPassword.invalid') + "'";
        messages = messages + ", " + "CLASSIFICATION_BUTTON_CREATE: '" + message(code: 'classification.button.create') + "'";
        messages = messages + ", " + "CLASSIFICATION_BUTTON_ZERO: '" + message(code: 'classification.button.zero') + "'";
        messages = messages + ", " + "CLASSIFICATION_BUTTON_DELETE: '" + message(code: 'classification.button.delete') + "'";
        messages = messages + ", " + "CLASSIFICATION_NAME_LABEL: '" + message(code: 'classification.name.label') + "'";
        messages = messages + ", " + "CLASSIFICATION_CONFIRM_DELETE: '" + message(code: 'classification.confirm.delete') + "'";
        messages = messages + ", " + "STORAGE_BUTTON_CREATE: '" + message(code: 'storage.button.create') + "'";
        messages = messages + ", " + "STORAGE_BUTTON_DELETE: '" + message(code: 'storage.button.delete') + "'";
        messages = messages + ", " + "STORAGE_NAME_LABEL: '" + message(code: 'storage.name.label') + "'";
        messages = messages + ", " + "STORAGE_CONFIRM_DELETE: '" + message(code: 'storage.confirm.delete') + "'";
        messages = messages + ", " + "FILE_TAGS_LABEL: '" + message(code: 'file.tags.label') + "'";
        messages = messages + ", " + "FILE_CONFIRM_DELETE: '" + message(code: 'file.confirm.delete') + "'";
        render(contentType: "text/javascript", text: "var i18n = {" + messages + "}")
    }
}
