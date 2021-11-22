import api from "./axios";
import { Contact } from "./type";

export const getContacts = (pageSize:number, pageNumber:number) => {
  return api.get("/contacts?page_size="+pageSize+"&page_number="+pageNumber)
}

export const createContact = (contact: Contact) => {
  return api.post("/contacts", contact)
}

export const updateContact = (contact: Contact) => {
  return api.put("/contacts/" + contact.id + "/", contact)
}

export const deleteContact = (contact_id: number) => {
  return api.delete("/contacts/" + contact_id)
}

export const contactEditHistory = (contact_id: number) => {
  return api.get("/contacts/" + contact_id + "/show_edit_history/")
}