function Demo_Canny()


            a_file_name='ANPR_img_04.jpg';
            
            input_image=imread(a_file_name);
            figure;
            imagesc(rgb2gray(input_image));
            title('original_image');
            colormap gray;
            th1=0.04;
            th2=0.02;
            gaussian_filter=1;
            edge=canny_edges(input_image, th1, th2, gaussian_filter );
            imwrite(edge,['Output' '_' num2str(idx-1,'%d') '_' ...
                num2str(th1,'%.2f') '_' num2str(th2,'%.2f') '_' ...
                num2str(gaussian_filter,'%.2f') '.jpg']);
            figure;
            imagesc(edge);
            colormap gray;
            title([num2str(th1,'%.2f') '_' num2str(th2,'%.2f') '_' ...
                num2str(gaussian_filter,'%.2f')]);
            th1=0.02;
            edge=canny_edges(input_image, th1, th2, gaussian_filter );
            imwrite(edge,['Output' '_' num2str(idx-1,'%d') '_' ...
                num2str(th1,'%.2f') '_' num2str(th2,'%.2f') '_' ...
                num2str(gaussian_filter,'%.2f') '.jpg']);
            figure;
            imagesc(edge);
            colormap gray;
            title([num2str(th1,'%.2f') '_' num2str(th2,'%.2f') '_' ...
                num2str(gaussian_filter,'%.2f')]);
            th1=0.06;
            edge=canny_edges(input_image, th1, th2, gaussian_filter );
            imwrite(edge,['Output' '_' num2str(idx-1,'%d') '_' ...
                num2str(th1,'%.2f') '_' num2str(th2,'%.2f') '_' ...
                num2str(gaussian_filter,'%.2f') '.jpg']);
            figure;
            imagesc(edge);
            colormap gray;
            title([num2str(th1,'%.2f') '_' num2str(th2,'%.2f') '_' ...
                num2str(gaussian_filter,'%.2f')]);
            th1=0.04;
            th2=0.01;
            edge=canny_edges(input_image, th1, th2, gaussian_filter );
            imwrite(edge,['Output' '_' num2str(idx-1,'%d') '_' ...
                num2str(th1,'%.2f') '_' num2str(th2,'%.2f') '_' ...
                num2str(gaussian_filter,'%.2f') '.jpg']);
            figure;
            imagesc(edge);
            colormap gray;
            title([num2str(th1,'%.2f') '_' num2str(th2,'%.2f') '_' ...
                num2str(gaussian_filter,'%.2f')]);
            th2=0.06;
            edge=canny_edges(input_image, th1, th2, gaussian_filter );
            imwrite(edge,['Output' '_' num2str(idx-1,'%d') '_' ...
                num2str(th1,'%.2f') '_' num2str(th2,'%.2f') '_' ...
                num2str(gaussian_filter,'%.2f') '.jpg']);
            figure;
            imagesc(edge);
            colormap gray;
            title([num2str(th1,'%.2f') '_' num2str(th2,'%.2f') '_' ...
                num2str(gaussian_filter,'%.2f')]);
            th2=0.02;
            gaussian_filter=0.5;
            edge=canny_edges(input_image, th1, th2, gaussian_filter );
            imwrite(edge,['Output' '_' num2str(idx-1,'%d') '_' ...
                num2str(th1,'%.2f') '_' num2str(th2,'%.2f') '_' ...
                num2str(gaussian_filter,'%.2f') '.jpg']);
           
            figure;
            imagesc(edge);
            colormap gray;
            title([num2str(th1,'%.2f') '_' num2str(th2,'%.2f') '_' ...
                num2str(gaussian_filter,'%.2f')]);
            gaussian_filter=5;
            edge=canny_edges(input_image, th1, th2, gaussian_filter );
            imwrite(edge,['Output' '_' num2str(idx-1,'%d') '_' ...
                num2str(th1,'%.2f') '_' num2str(th2,'%.2f') '_' ...
                num2str(gaussian_filter,'%.2f') '.jpg']);
            figure;
            imagesc(edge);
            colormap gray;
            title([num2str(th1,'%.2f') '_' num2str(th2,'%.2f') '_' ...
                num2str(gaussian_filter,'%.2f')]);

end