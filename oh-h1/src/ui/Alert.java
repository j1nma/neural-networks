package ui;

import javafx.stage.*;
import javafx.scene.*;
import javafx.scene.layout.*;
import javafx.scene.control.*;
import javafx.geometry.*;

public class Alert{

    public static void display(String title, String message) {
        Stage window = new Stage();

        window.initModality(Modality.APPLICATION_MODAL);
        window.setTitle(title);
        window.setHeight(150);
		window.setWidth(400);

        Label label = new MyLabel(message,0,10,400,50);
   
       
        Button cerrar = new Button("Cerrar");
        cerrar.setId("blueButton");
        cerrar.setOnAction(e -> window.close());

        VBox layout = new VBox();
        layout.getChildren().addAll(label, cerrar);
        layout.setAlignment(Pos.CENTER);
   

        Scene scene = new Scene(layout);
        scene.getStylesheets().add("/assets/application.css");
        
        window.setScene(scene);
        window.showAndWait();
    }

}