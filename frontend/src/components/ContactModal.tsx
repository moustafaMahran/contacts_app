import {
  IonAlert,
  IonButton,
  IonFab,
  IonFabButton,
  IonGrid,
  IonIcon,
  IonInput,
  IonItem,
  IonLabel,
  IonModal,
  IonRow,
  IonTitle,
} from "@ionic/react";
import { close, pencil } from "ionicons/icons";
import { useEffect, useState } from "react";
import { createContact, updateContact } from "../shared/api";
import { Contact } from "../shared/type";
import "./ContactModal.css";
import isEmail from "validator/lib/isEmail";
import isMobilePhone from "validator/lib/isMobilePhone";

interface ContactModalProps {
  contact: Contact;
  showModal: boolean;
  onClose: any;
  onAction: any;
  action: string;
}

const ContactModal: React.FC<ContactModalProps> = ({
  contact,
  showModal,
  onClose,
  onAction,
  action,
}) => {
  const [firstName, setFirstName] = useState("");
  const [lastName, setLastName] = useState("");
  const [phoneNumber, setPhoneNumber] = useState("");
  const [email, setEmail] = useState("");
  const [errorMessage, setErrorMessage] = useState("");
  const [showError, setShowError] = useState(false);

  useEffect(() => {
    if (contact) {
      setFirstName(contact.firstName);
      setLastName(contact.lastName);
      setPhoneNumber(contact.phoneNumber);
      setEmail(contact.email);
    }
  }, [contact]);

  const createNewContact = () => {
    if (!isEmail(email)) {
      setErrorMessage("Email is Invalid");
      setShowError(true);
      return;
    }

    if (!isMobilePhone(phoneNumber)) {
      setErrorMessage("Phone number is Invalid");
      setShowError(true);
      return;
    }

    let newContact: Contact = {
      id: null,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
    };
    createContact(newContact)
      .then((response) => {
        onAction();
      })
      .catch((err) => {
        setErrorMessage(JSON.stringify(err?.response?.data));
        setShowError(true);
      });
  };

  const updateCurrentContact = () => {
    if (!isEmail(email)) {
      setErrorMessage("Email is Invalid");
      setShowError(true);
      return;
    }

    if (!isMobilePhone(phoneNumber)) {
      setErrorMessage("Phone number is Invalid");
      setShowError(true);
      return;
    }

    let currentContact: Contact = {
      id: contact.id,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
    };
    updateContact(currentContact)
      .then((response) => {
        onAction();
      })
      .catch((err) => {
        setErrorMessage(JSON.stringify(err?.response?.data));
        setShowError(true);
      });
  };

  return (
    <IonModal isOpen={showModal} onDidDismiss={onClose}>
      <IonGrid className="modalGrid">
        <IonRow>
          <IonTitle className="modalTitle" size="large" color="dark">
            {action === "create" ? "Create" : "Update"} Contact
          </IonTitle>
        </IonRow>
        <IonItem className="modalInput">
          <IonLabel position="floating">First Name*</IonLabel>
          <IonInput
            value={firstName}
            onIonChange={(e) => setFirstName(e.detail.value!)}
          ></IonInput>
        </IonItem>
        <IonItem className="modalInput">
          <IonLabel position="floating">Last Name*</IonLabel>
          <IonInput
            value={lastName}
            onIonChange={(e) => setLastName(e.detail.value!)}
          ></IonInput>
        </IonItem>
        <IonItem className="modalInput">
          <IonLabel position="floating">Phone Number*</IonLabel>
          <IonInput
            value={phoneNumber}
            onIonChange={(e) => setPhoneNumber(e.detail.value!)}
          ></IonInput>
        </IonItem>
        <IonItem className="modalInput">
          <IonLabel position="floating">Email*</IonLabel>
          <IonInput
            value={email}
            type="email"
            onIonChange={(e) => setEmail(e.detail.value!)}
          ></IonInput>
        </IonItem>
        <IonButton
          color="dark"
          onClick={
            action === "create" ? createNewContact : updateCurrentContact
          }
          expand="block"
          fill="outline"
          className="marginTopBottom"
        >
          {action === "update" && <IonIcon icon={pencil} slot="end" />}
          {action === "create" ? "Create" : "Update"} Contact
        </IonButton>
      </IonGrid>

      <IonAlert
        isOpen={showError}
        onDidDismiss={() => setShowError(false)}
        header={"Cannot perform your request!"}
        message={errorMessage}
        buttons={["OK"]}
      />
      
      <IonFab vertical="top" horizontal="end" slot="fixed">
        <IonFabButton color="medium" size="small" onClick={onClose}>
          <IonIcon icon={close} />
        </IonFabButton>
      </IonFab>
    </IonModal>
  );
};

export default ContactModal;
