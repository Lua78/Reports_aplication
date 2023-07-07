
class ReportsController < ApplicationController
    def new
        @report = Report.new
    end

    def index
        @reports = Report.with_attached_photo
        filter = Report::TIME_FILTER.fetch(params[:filter]&.to_sym, Report::TIME_FILTER['all'.to_sym])
        @reports = @reports.where(filter).order(created_at: :desc).load_async
        @pagy, @reports = pagy_countless(@reports,items: 10)

    end

    def show
        if report.visto==false then
            report.update(visto:true)
        end

    end

    def create
        @report = Report.new(report_params)
        if @report.save
            redirect_to reports_path, notice: 'Reporte agregado'
        else
            render :new,status: :unprocessable_entity, notice: 'Ha ocurrido un error al crear el reporte.'
        end

    end
    def edit
        report
    end

    def update
        if report.update(report_params)
        
            redirect_to reports_path, notice: 'Reporte Actualizado'
        else
            render new
        end
        
    end

    def destroy
        if report.destroy
            redirect_to reports_path,notice: 'Reporte Eliminado',status: :see_other
        else
            render reports_path
        end

    end

    private
    def  report_params
        params.require(:report).permit(:user,:tittle,:description,:photo,:category_id)
    end

    def report
        @report = Report.find(params[:id])
    end

end