FROM amazoncorretto:21
ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar open.jar
ENTRYPOINT ["java", "-jar", "open.jar"]