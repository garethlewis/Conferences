require 'rho/rhoapplication'
require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'

class AgendasController < Rho::RhoController
  include BrowserHelper

  # GET /Agendas
  def index
    @agendases = Agendas.find(:all)
    render :back => '/app'
  end

  # GET /Agendas/{1}
  def show
    @agendas = Agendas.find(@params['id'])
    if @agendas
      ses = @agendas.Sessions
      ses = ses.split("::")
      @sessions = Hash[*ses]
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Agendas/new
  def new
    @agendas = Agendas.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Agendas/{1}/edit
  def edit
    @agendas = Agendas.find(@params['id'])
    if @agendas
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Agendas/create
  def create
    @agendas = Agendas.create(@params['agendas'])
    redirect :action => :index
  end

  # POST /Agendas/{1}/update
  def update
    @agendas = Agendas.find(@params['id'])
    @agendas.update_attributes(@params['agendas']) if @agendas
    redirect :action => :index
  end

  # POST /Agendas/{1}/delete
  def delete
    @agendas = Agendas.find(@params['id'])
    @agendas.destroy if @agendas
    redirect :action => :index  
  end
end
