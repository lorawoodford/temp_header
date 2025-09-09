class TempHeadersController < ApplicationController
  set_access_control 'administer_system' => [:index, :edit, :update, :reset]

  def index
    redirect_to ({ controller: :temp_headers, action: :edit })
  end

  def edit
    @temp_header = JSONModel(:temp_header).all.first
  end

  def update
    @temp_header = JSONModel(:temp_header).all.first

    handle_crud(:instance => :temp_header,
                :model => JSONModel(:temp_header),
                :replace => true,
                :obj => @temp_header,
                :on_invalid => ->() {
                  return render action: 'edit'
                },
                :on_valid => ->(id) {
                  flash[:success] = I18n.t('temp_header._frontend.messages.updated')
                  redirect_to :controller => :temp_headers, :action => :edit
                })
  end

  def reset
    begin
      temp_header = JSONModel(:temp_header).all.first
      temp_header.update({
        show_header: false,
        notice_date: nil,
        maintenance_start: nil,
        maintenance_end: nil,
        maintenance_message: nil
      })
      temp_header.save

      flash[:success] = t('temp_header._frontend.messages.reset')
      redirect_to ({ controller: :temp_headers, action: :edit })
    rescue Exception => e
      flash[:error] = t('temp_header._frontend.messages.reset_error', :exception => e)
      redirect_to ({ controller: :temp_headers, action: :edit })
      return
    end
  end

  def current_record
    @temp_header
  end

end
