public with sharing class GenerateHolidayGreetingImage {
    
    @InvocableMethod(label='Generate Holiday Greeting Image' 
                     description='Calls external service to generate personalized holiday greeting card image')
    public static List<HolidayGreetingGenerator.ImageResponse> generateGreetingImage(List<Request> requests) {
        List<HolidayGreetingGenerator.ImageResponse> responses = new List<HolidayGreetingGenerator.ImageResponse>();
        
        for (Request req : requests) {
            try {
                // Use HolidayGreetingGenerator's ImageResponse directly
                HolidayGreetingGenerator.ImageResponse response = HolidayGreetingGenerator.callExternalImageService(
                    req.recipientName,
                    req.message, 
                    req.templateId,
                    req.senderName
                );
                responses.add(response);
            } catch (Exception e) {
                // Create error response using HolidayGreetingGenerator's type
                HolidayGreetingGenerator.ImageResponse errorResponse = new HolidayGreetingGenerator.ImageResponse();
                errorResponse.downloadUrl = 'Error: ' + e.getMessage();
                responses.add(errorResponse);
            }
        }
        return responses;
    }
    
    public class Request {
        @InvocableVariable(required=true description='Recipient name (To)')
        public String recipientName;
        
        @InvocableVariable(required=true description='Personalized message from prompt')
        public String message;
        
        @InvocableVariable(required=true description='Template ID from LWC selector')
        public String templateId;
        
        @InvocableVariable(required=true description='Sender name (From)')
        public String senderName;
    }
}