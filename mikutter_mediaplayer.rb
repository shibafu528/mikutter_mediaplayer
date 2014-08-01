# -*- coding: utf-8 -*-

Plugin.create(:mikutter_mediaplayer) do
    
    command(:open_mp,
        name: "サウンドファイルを再生",
        condition: lambda{ |opt| true },
        visible: false,
        role: :window) do
        dialog = Gtk::FileChooserDialog.new("サウンドファイルを開く",
            $main_application_window,
            Gtk::FileChooser::ACTION_OPEN,
            nil,
            [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL],
            [Gtk::Stock::OPEN, Gtk::Dialog::RESPONSE_ACCEPT])
        if dialog.run == Gtk::Dialog::RESPONSE_ACCEPT then
            Plugin.call(:gst_enq, dialog.filename, :mikutter_mediaplayer)
        end
        dialog.destroy
    end

    command(:stop_mp,
        name: "停止",
        condition: lambda{ |opt| true },
        visible: false,
        role: :window) do
        Plugin.call(:gst_stop, :mikutter_mediaplayer)
    end
end
