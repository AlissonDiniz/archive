/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function DateUtil(){
    
    var self = this;
    
    function formatDate(dateVar){
        return moment(dateVar).format(i18n.DEFAULT_DATE_FORMAT.toUpperCase());
    };
    
    function getHttpDate(stringDate){
        return moment(moment(stringDate, i18n.DEFAULT_DATE_FORMAT.toUpperCase()).toDate()).format('YYYY-MM-DD HH:mm:ss.S');
    }
    
    self.formatDate = formatDate;
    self.getHttpDate = getHttpDate;
}
