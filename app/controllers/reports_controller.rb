
class ReportsController < ApplicationController
    def new
        @report = Report.new
    end

    def index
        @reports = Report.with_attached_photo.order(created_at: :desc)
    end

    def show
        report
    end

    def create
        @report = Report.new(report_params)
        if @report.save
            redirect_to reports_path, notice: 'Reporte agregado'
        else
            render new, alert: 'Ha ocurrido un error al crear el reporte'
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