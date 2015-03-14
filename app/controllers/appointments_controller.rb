#encoding: utf-8
class AppointmentsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :find_appointment, only: [:destroy]
  before_filter :authenticate_user_is_owner, only: [:destroy]
  
  def create
    @appointment = Appointment.create(appointment_params)
    if @appointment.save
      publish_str = @appointment.offer.published ? "Ahora puedes publicarlo :)" : nil
      flash[:notice] = "Se añadió una fecha de recolección para este reciclable. #{publish_str}"
    else
      flash[:error] = "No fué posible añadir una fecha de recolección para este reciclable."
    end
    
    if @appointment.offer.published
      redirect_to user_activity_path.concat("#/published/#{@appointment.offer.id}/collect")
    else
      redirect_to user_activity_path.concat("#/unpublished/#{@appointment.offer.id}/collect")
    end
  end
  
  def destroy
    offer = @appointment.offer
    if @appointment.destroy      
      if offer.appointments.size == 0
        offer.update_attribute(:published, false) 
        flash[:warning] = "La ÚNICA fecha de recolección asignada a este reciclable fué eliminada correctamente, pero este, ya no está publicado."
      else
        flash[:notice] = "La fecha de recolección fué eliminada correctamente."
      end
      
      if offer.published
        redirect_to user_activity_path.concat("#/published/#{offer.id}/collect")
      else
        redirect_to user_activity_path.concat("#/unpublished/#{offer.id}/collect")
      end
    else
      flash[:error] = "No fué posible eliminar la fecha de recolección."
    end
  end
  
  private

  def appointment_params
    params.require(:appointment).permit(
      :notes,
      :meeting_time,
      :offer_id
    )
  end
  
  def find_appointment
    @appointment = Appointment.find(params[:id])
  end
  
  def authenticate_user_is_owner
    @appointment.offer.user == current_user
  end
end
