import {
  IonAlert,
  IonButtons,
  IonCol,
  IonContent,
  IonFab,
  IonFabButton,
  IonGrid,
  IonHeader,
  IonIcon,
  IonItem,
  IonItemOption,
  IonItemOptions,
  IonItemSliding,
  IonLabel,
  IonList,
  IonNote,
  IonPage,
  IonRow,
  IonTitle,
  IonToggle,
  IonToolbar,
} from "@ionic/react";
import {
  add,
  arrowBackCircleOutline,
  arrowForwardCircleOutline,
  list,
  pencil,
  trash,
} from "ionicons/icons";
import { useEffect, useState } from "react";
import ContactModal from "../components/ContactModal";
import EditHistoryModal from "../components/EditsHistoryModal";
import { deleteContact, getContacts } from "../shared/api";
import { SkeletonComponent } from "../components/skeleton";
import { Contact } from "../shared/type";
import "./Contacts.css";

const ContactsPage: React.FC = () => {
  const [contacts, setContacts] = useState<Contact[]>();
  const [selectedContact, setSelectedContact] = useState<Contact>();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [hasError, setHasError] = useState(false);
  const [showModal, setShowModal] = useState(false);
  const [modalAction, setModalAction] = useState("create");
  const [showHistory, setShowHistory] = useState(false);
  const [showConfirmationMsg, setShowConfirmationMsg] = useState(false);
  const [errorMessage, setErrorMessage] = useState("");
  const [showError, setShowError] = useState(false);
  const [pageNumber, setPageNumber] = useState(1);
  const pageSize = 6;

  useEffect(() => {
    if (!contacts) fetchContacts(pageNumber);
  }, [contacts, selectedContact, hasError]);

  const fetchContacts = (page: number) => {
    setLoading(true);
    getContacts(pageSize, page)
      .then((response) => {
        setContacts(response.data as Contact[]);
      })
      .catch((err) => {
        setError(err);
        console.log(error); // should use any error reporting library eg. Crashlytics, Sentury...etc
        setHasError(true);
      })
      .finally(() => {
        setLoading(false);
      });
  };

  const afterModalAction = () => {
    setShowModal(false);
    fetchContacts(pageNumber);
  };

  const showModalForUpdate = (contact: Contact) => {
    setSelectedContact(contact);
    setModalAction("update");
    setShowModal(true);
  };

  const showModalForCreate = () => {
    setSelectedContact({
      firstName: "",
      lastName: "",
      phoneNumber: "",
      email: "",
    } as Contact);
    setModalAction("create");
    setShowModal(true);
  };

  const deleteCurrentContact = () => {
    deleteContact(selectedContact?.id!)
      .then((response) => {
        afterModalAction();
      })
      .catch((err) => {
        setErrorMessage(JSON.stringify(err?.response?.data));
        setShowError(true);
      });
  };

  const toggleDarkModeHandler = () => {
    document.body.classList.toggle("dark");
  }

  return (
    <IonPage>
      <IonHeader>
        <IonToolbar>
          <IonTitle className="centered">My Contacts</IonTitle>
          <IonButtons slot="end">
          <IonToggle color="dark" onIonChange={toggleDarkModeHandler} />
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonList>
          {loading ? (
            <SkeletonComponent />
          ) : hasError ? (
            <IonItem>
              <IonLabel>
                <h3>Something went wrong! Please try again...</h3>
              </IonLabel>
            </IonItem>
          ) : contacts?.length === 0 ? (
            <IonItem className="centered">
              <IonLabel>
                <h2>No Contacts Left</h2>
              </IonLabel>
            </IonItem>
          ) : (
            <IonGrid>
              <IonRow>
                {contacts?.map((contact, index) => {
                  return (
                    <IonCol size-sm="6" size-xs="12" key={contact.id}>
                      <IonItemSliding id={contact?.id?.toString()}>
                        <IonItem>
                          <IonLabel>
                            <h2>
                              {contact.firstName + " " + contact.lastName}
                            </h2>
                            <p>Phone Number: {contact.phoneNumber}</p>
                            <p>Email: {contact.email}</p>
                          </IonLabel>
                          <IonNote slot="end">slide to edit</IonNote>
                        </IonItem>

                        <IonItemOptions side="end">
                          <IonItemOption
                            color="danger"
                            onClick={() => {
                              setSelectedContact(contact);
                              setShowConfirmationMsg(true);
                            }}
                          >
                            <IonIcon slot="icon-only" icon={trash} />
                          </IonItemOption>
                          <IonItemOption
                            color="light"
                            onClick={() => {
                              setSelectedContact(contact);
                              setShowHistory(true);
                            }}
                          >
                            <IonIcon slot="icon-only" icon={list} />
                          </IonItemOption>
                          <IonItemOption
                            onClick={() => showModalForUpdate(contact)}
                          >
                            <IonIcon slot="icon-only" icon={pencil} />
                          </IonItemOption>
                        </IonItemOptions>
                      </IonItemSliding>
                    </IonCol>
                  );
                })}
              </IonRow>
            </IonGrid>
          )}
        </IonList>
        <ContactModal
          contact={selectedContact!}
          showModal={showModal}
          onClose={() => setShowModal(false)}
          onAction={afterModalAction}
          action={modalAction}
        />
        <EditHistoryModal
          contact_id={selectedContact?.id || 0}
          showModal={showHistory}
          onClose={() => setShowHistory(false)}
        />
        <IonFab vertical="bottom" horizontal="center" slot="fixed">
          <IonFabButton color="dark" onClick={showModalForCreate}>
            <IonIcon icon={add} />
          </IonFabButton>
        </IonFab>
        <IonFab
          vertical="bottom"
          horizontal="end"
          slot="fixed"
          className="paginationButton"
        >
          <IonFabButton
            color="dark"
            onClick={() => {
              fetchContacts(pageNumber + 1);
              setPageNumber(pageNumber + 1);
            }}
            disabled={contacts && contacts.length < pageSize}
          >
            <IonIcon icon={arrowForwardCircleOutline} />
          </IonFabButton>
        </IonFab>
        <IonFab
          vertical="bottom"
          horizontal="start"
          slot="fixed"
          className="paginationButton"
        >
          <IonFabButton
            color="dark"
            onClick={() => {
              if (pageNumber === 1) return;
              fetchContacts(pageNumber - 1);
              setPageNumber(pageNumber - 1);
            }}
            disabled={pageNumber <= 1}
          >
            <IonIcon icon={arrowBackCircleOutline} />
          </IonFabButton>
        </IonFab>
        <IonAlert
          isOpen={showConfirmationMsg}
          onDidDismiss={() => setShowConfirmationMsg(false)}
          header={"Confirmation"}
          message={
            "Are you sure you want to delete contact " +
            selectedContact?.firstName +
            " " +
            selectedContact?.lastName +
            "?"
          }
          buttons={[
            {
              text: "Cancel",
              role: "cancel",
              handler: () => {
                setShowConfirmationMsg(false);
              },
            },
            {
              text: "Delete",
              cssClass: "danger",
              handler: () => {
                setShowConfirmationMsg(false);
                deleteCurrentContact();
              },
            },
          ]}
        />
        <IonAlert
          isOpen={showError}
          onDidDismiss={() => setShowError(false)}
          header={"Cannot perform your request!"}
          message={errorMessage}
          buttons={["OK"]}
        />
      </IonContent>
    </IonPage>
  );
};

export default ContactsPage;
