class PatientsController < AuthController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
    @patients = Patient.all.order(:id)
  end

  def show
  end

  def new
    @patient = Patient.new
  end

  def edit
  end

  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      redirect_to "/patients/#{@patient.id}/mri_images", notice: 'Patient was successfully created.'
    else
      render :new
    end
  end

  def update
    if @patient.update(patient_params)
      flash[:notice] = 'Patient was successfully updated.'
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    @patient.destroy
    redirect_to patients_url, notice: 'Patient was successfully destroyed.'
  end

  private
    def set_patient
      @patient = Patient.find(params[:id])
    end

    def patient_params
      params.require(:patient)
        .permit(
          :name,
          :read,
          :injury_date,
          :player_id,
          :player_position,
          :reinjury,
          :number_of_muscles,
          :muscle,
          :peetrons_grade,
          :origin_lesion_distance,
          :muscle_length,
          :free_tendon_involvement,
          :central_tendon_disruption,
          :musculotendinous,
          :free_tendon_proximal_distal,
          :central_tendon_proximal_distal, 
          :musculotendinous_proximal_distal,
          :fluid_collection,
          :retraction_distance,
          :edema_largest_csa,
          :edema_longitude_length,
          :hamstring_largest_csa,
          :quadricep_largest_csa,
          :secondary_muscle,
          :secondary_peetrons_grade,
          :secondary_origin_lesion_distance,
          :secondary_muscle_length,
          :secondary_free_tendon_involvement,
          :secondary_central_tendon_disruption,
          :secondary_musculotendinous,
          :secondary_free_tendon_proximal_distal,
          :secondary_central_tendon_proximal_distal, 
          :secondary_musculotendinous_proximal_distal,
          :secondary_fluid_collection,
          :secondary_retraction_distance,
          :secondary_edema_largest_csa,
          :secondary_edema_longitude_length,
          :secondary_hamstring_largest_csa,
          :secondary_quadricep_largest_csa)
    end
end
