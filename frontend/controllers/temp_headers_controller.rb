require 'net/http'
require 'uri'
require 'aspace_logger'

class TempHeadersController < ApplicationController
  set_access_control "administer_system" => [:index, :new, :edit, :create, :update]

  def index
    @temp_header = JSONModel(:temp_header).all.first
  end

  # def show
  #   @temp_header = JSONModel(:temp_header).all.first
  # end

  # def new
  #   @temp_header = JSONModel(:temp_header).new._always_valid!
  # end

  def edit
    @temp_header = JSONModel(:temp_header).all.first
  end

  # def create
  #   handle_crud(:instance => :temp_header,
  #               :model => JSONModel(:temp_header),
  #               :on_invalid => ->() { render action: "new" },
  #               :on_valid => ->(id) {
  #                   flash[:success] = I18n.t("temp_header._frontend.messages.created")
  #                   redirect_to(:controller => :temp_headers,
  #                               :action => :edit,
  #                               :id => id) })
  # end

  def update
    @temp_header = JSONModel(:temp_header).all.first

    handle_crud(:instance => :temp_header,
                :model => JSONModel(:temp_header),
                :replace => true,
                :obj => @temp_header,
                :on_invalid => ->() {
                  return render action: "edit"
                },
                :on_valid => ->(id) {
                  flash[:success] = I18n.t("plugins.temp_header._frontend.messages.updated")
                  redirect_to :controller => :temp_headers, :action => :edit
                })
  end

  def current_record
    @temp_header
  end
  # def delete
  #   temp_header = JSONModel(:temp_header).find(params[:id])
  #   project_id = temp_header['project_id']
  #   begin
  #     temp_header.delete
  #   rescue ConflictException => e
  #     flash[:error] = I18n.t("temp_header._frontend.messages.delete_conflict", :error => I18n.t("errors.#{e.conflicts}", :default => e.message))
  #     return redirect_to(:controller => :temp_headers, :action => :show, :id => params[:id])
  #   end

  #   JSONModel::HTTP::post_form("/temp_headers/clear_cache", {:project_id => project_id})
  #   flash[:success] = I18n.t("temp_header._frontend.messages.deleted")
  #   redirect_to(:controller => :temp_headers, :action => :index, :deleted_uri => temp_header.uri)
  # end

end
