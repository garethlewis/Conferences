require 'rho/rhocontroller'
require 'helpers/browser_helper'

class EventSponsorsController < Rho::RhoController
  include BrowserHelper

  # GET /EventSponsors
  def index
    @eventsponsorses = EventSponsors.find(:all)
    render :back => '/app'
  end

  # GET /EventSponsors/{1}
  def show
    @eventsponsors = EventSponsors.find(@params['id'])
    if @eventsponsors
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /EventSponsors/new
  def new
    @eventsponsors = EventSponsors.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /EventSponsors/{1}/edit
  def edit
    @eventsponsors = EventSponsors.find(@params['id'])
    if @eventsponsors
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /EventSponsors/create
  def create
    @eventsponsors = EventSponsors.create(@params['eventsponsors'])
    redirect :action => :index
  end

  # POST /EventSponsors/{1}/update
  def update
    @eventsponsors = EventSponsors.find(@params['id'])
    @eventsponsors.update_attributes(@params['eventsponsors']) if @eventsponsors
    redirect :action => :index
  end

  # POST /EventSponsors/{1}/delete
  def delete
    @eventsponsors = EventSponsors.find(@params['id'])
    @eventsponsors.destroy if @eventsponsors
    redirect :action => :index  
  end
end
