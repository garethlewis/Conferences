require 'rho/rhocontroller'
require 'helpers/browser_helper'

class EMEAController < Rho::RhoController
  include BrowserHelper

  # GET /EMEA
  def index
    @emeas = EMEA.find(:all)
    render :back => '/app'
  end

  # GET /EMEA/{1}
  def show
    @emea = EMEA.find(@params['id'])
    if @emea
      type = @emea.type
      if !type.nil? || !type.empty?
        if type == "eventsponsors"
          @eventsponsor = EventSponsors.find(:all)
        end
      end
      # We now need to load the data for this particular type
      #render :action => :show_eventsponsors, :back => url_for(:action => :index, :model => :EventSponsors)
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /EMEA/new
  def new
    @emea = EMEA.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /EMEA/{1}/edit
  def edit
    @emea = EMEA.find(@params['id'])
    if @emea
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /EMEA/create
  def create
    @emea = EMEA.create(@params['emea'])
    redirect :action => :index
  end

  # POST /EMEA/{1}/update
  def update
    @emea = EMEA.find(@params['id'])
    @emea.update_attributes(@params['emea']) if @emea
    redirect :action => :index
  end

  # POST /EMEA/{1}/delete
  def delete
    @emea = EMEA.find(@params['id'])
    @emea.destroy if @emea
    redirect :action => :index  
  end
end
