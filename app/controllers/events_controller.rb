class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    @projects = current_user.projects

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # fomat for "when":
  # yy-mm-dd hh:mm
  # with hh running from 0 to 23
  # str = DateTime.now.strftime("%y-%m-%e %H:%M")
  # newdate = DateTime.strptime(str, "%y-%m-%e %H:%M")
  #
  # To create a record, the user must be signed in --
  # or a unique password must be provided.
  def create
    puts "*************"
    puts params.inspect

    if params[:event].key?(:pass)
      password = params[:event][:pass]
      user = User.find_by_hashed_secret(password)
      puts "user: #{user.inspect}"
    else
      # verify_signed_in
      user = current_user
    end

    @event = Event.new
    @event[:file] = params[:event][:file]
    # @event[:event_time] = params[:event][:event_time]
    @event.formatted_time = params[:event][:event_time]

    if @event.project.nil?
      if user.current_project.nil?
        puts "No current project. Redirecting."
        redirect_to :projects, :notice => "Sorry, you need a current project."
        return
      end
      @event.project = user.current_project
    end

    respond_to do |format|
      if @event.save
    puts
    puts "*****************"
    puts @event.inspect
        format.html { redirect_to @event.project, :notice => "Event saved" }
        format.json { render :json => { :saved => "true" } }
      else
        format.html { redirect_to :new_event, :notice => "Event not saved" }
        format.json { render :json => { :saved => "false" } }
      end
    end
  end




  # POST /events
  # POST /events.xml
  # def create
  #   @event = Event.new(params[:event])
  #   @projects = current_user.projects

  #   respond_to do |format|
  #     if @event.save
  #       format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
  #       format.xml  { render :xml => @event, :status => :created, :location => @event }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
end
