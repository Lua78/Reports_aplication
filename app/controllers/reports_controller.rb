
class ReportsController < ApplicationController
    def new
        @report = Report.new
    end

    def index
        if Current.user::admin==true then
            filter = Report::TIME_FILTER_ADMIN.fetch(params[:filter]&.to_sym, Report::TIME_FILTER['all'.to_sym])
            if params[:visibilidad]=="Todos" then
                @reports = Report.with_attached_photo.where(filter).order(created_at: :desc).load_async
            elsif params[:visibilidad] then
                @reports = Report.with_attached_photo.where(filter+" and visto =#{params[:visibilidad]}").order(created_at: :desc).load_async
            else
                @reports = Report.with_attached_photo.where(filter).order(created_at: :desc).load_async
            end
        else
            filter = Report::TIME_FILTER.fetch(params[:filter]&.to_sym, Report::TIME_FILTER['all'.to_sym])
            @reports = Report.with_attached_photo.where(filter).order(created_at: :desc).load_async
        end
        @pagy, @reports = pagy_countless(@reports,items: 10)
    end

    def show
        authorize report
        if report.visto==false then
            report.update(visto:true)
        end

    end

    def create 
        @report = Report.new(report_params)
        @report.nameuser = Current.user::name
        pp @report::nameuser
        if @report.save
            redirect_to reports_path, notice: 'Reporte agregado'
        else
            render :new,status: :unprocessable_entity, notice: 'Ha ocurrido un error al crear el reporte.'
        end

    end
    def edit
        authorize report
    end

    def update
        authorize  report
        if report.update(report_params)
        
            redirect_to reports_path, notice: 'Reporte Actualizado'
        else
            render new
        end
        
    end

    def destroy
        authorize report
        if report.destroy
            redirect_to reports_path,notice: 'Reporte Eliminado',status: :see_other
        else
            render reports_path
        end

    end

    private
    def  report_params
        params.require(:report).permit(:tittle,:description,:photo,:category_id)
    end

    def report
        @report = Report.find(params[:id])
    end

end