module ApplicationHelper

    def active_item(uri)
        uri_segment = request.fullpath.split(/\/|\?/)
        uri_segment[1] === uri ? "active" : ""
    end
end
