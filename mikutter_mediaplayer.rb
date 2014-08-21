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
        
        filter = Gtk::FileFilter.new
        filter.name = "Media Files"
        filter.add_pattern("*.wav")
        filter.add_pattern("*.WAV")
        filter.add_pattern("*.mp3")
        filter.add_pattern("*.MP3")
        filter.add_pattern("*.mp4")
        filter.add_pattern("*.MP4")
        filter.add_pattern("*.m4a")
        filter.add_pattern("*.M4A")
        filter.add_pattern("*.m4v")
        filter.add_pattern("*.M4V")
        filter.add_pattern("*.avi")
        filter.add_pattern("*.AVI")
        filter.add_pattern("*.mpg")
        filter.add_pattern("*.MPG")
        filter.add_pattern("*.mpeg")
        filter.add_pattern("*.MPEG")
        filter.add_pattern("*.aac")
        filter.add_pattern("*.AAC")
        filter.add_pattern("*.ogg")
        filter.add_pattern("*.OGG")
        filter.add_pattern("*.flac")
        filter.add_pattern("*.FLAC")
        filter.add_pattern("*.fla")
        filter.add_pattern("*.FLA")
        dialog.add_filter(filter)

        filter = Gtk::FileFilter.new
        filter.name = "All Files"
        filter.add_pattern("*")
        dialog.add_filter(filter)
        
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

    filter_gst_mixer do |channels|
        channels << :mikutter_mediaplayer
        [channels]
    end
end
