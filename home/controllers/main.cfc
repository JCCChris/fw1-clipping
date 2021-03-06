component accessors="true" {

    /**
     * and we add a declaration that the controller depends on the new clippingService.cfc
     * (in model/services):
     */
    property clippingService;

    /**
     * init FW variables and methods so that they are available to this controller
     */
    property framework;

    /**
     * action = main or action = main.default
     */
    function default( struct rc ) {
        framework.frameworkTrace( "<b>Running query to list articles</b>");

        // default starting record
        param name="rc.page" default="1";
        if (!isNumeric(rc.page) or rc.page lt 1 or round(rc.page) neq rc.page){
            rc.page = 1;
        }

        rc.qry_clipping = variables.clippingService.list(page=rc.page, perpage=application.recordsPerPage); // returns a struct
    }

    /**
     * returns data without using layouts
     * a view with the same name (action=main.nolayout)
     */
    function nolayout( struct rc ) {
        // defines content type:
        // application/json; charset=utf-8
        // text/xml; charset=utf-8
        // text/plain; charset=utf-8
        var contentType = 'JSON';
        param name="rc.name" default="String returned without a layout";
        setting showdebugoutput='false';  // no debug output
        // return the whole RC struct as JSON
        framework.renderData( contentType, rc);
    }
}
