public class CreateContactFromEmailHandler implements Messaging.InboundEmailHandler{
    
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
                                                           Messaging.InboundEnvelope envelope) {
                                                               Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
                                                               String subToCompare = 'Create Contact';
                                                               List<Attachment> attachmentList = new List<Attachment>();
                                                               if(email.subject.equalsIgnoreCase(subToCompare)) {
                                                                   Contact c = new Contact();
                                                                   c.LastName = email.plainTextBody;
                                                                   insert c;
                                                                   
                                                                   // Save attachments, if any
                                                                   if(email.textAttachments!=null) {
                                                                       for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
                                                                           Attachment attachment = new Attachment();
                                                                           attachment.Name = tAttachment.fileName;
                                                                           attachment.Body = Blob.valueOf(tAttachment.body);
                                                                           attachment.ParentId = c.Id;
                                                                           attachmentList.add(attachment);
                                                                       }
                                                                   }
                                                                   
                                                                   //Save any Binary Attachment
                                                                   if(email.binaryAttachments!=null){
                                                                       for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
                                                                           Attachment attachment = new Attachment();
                                                                           attachment.Name = bAttachment.fileName;
                                                                           attachment.Body = bAttachment.body;
                                                                           attachment.ParentId = c.Id;
                                                                           attachmentList.add(attachment);
                                                                       }
                                                                   }
                                                                   
                                                                   if(!attachmentList.isEmpty()){
                                                                       insert attachmentList;
                                                                   }
                                                               }
                                                               result.success = true;
                                                               return result;
                                                           }

}