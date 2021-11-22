import {
  IonContent,
  IonFab,
  IonFabButton,
  IonGrid,
  IonIcon,
  IonItem,
  IonLabel,
  IonModal,
  IonRow,
  IonTitle,
} from "@ionic/react";
import { close } from "ionicons/icons";
import { useEffect, useState } from "react";
import { contactEditHistory } from "../shared/api";
import { EditHistory } from "../shared/type";
import "./EditHistoryModal.css";

interface EditsHistoryModalProps {
  contact_id: number;
  showModal: boolean;
  onClose: any;
}

const EditHistoryModal: React.FC<EditsHistoryModalProps> = ({
  contact_id,
  showModal,
  onClose,
}) => {
  const [audits, setAudits] = useState<EditHistory[]>();

  useEffect(() => {
    if (showModal && !audits) fetchAudits();
  }, [audits, contact_id, showModal]);

  const fetchAudits = () => {
    contactEditHistory(contact_id)
      .then((response) => {
        console.log(response.data);

        setAudits(response.data);
      })
      .catch((err) => {
        console.log(err);
      });
  };

  return (
    <IonModal
      isOpen={showModal}
      onDidDismiss={() => {
        setAudits(undefined);
        onClose();
      }}
    >
      <IonContent className="modalGrid">
        <IonRow>
          <IonTitle className="modalTitle" size="large" color="dark">
            Edit History
          </IonTitle>
        </IonRow>
        <IonGrid>
          {audits?.map((audit, index) => {
            return (
              <IonGrid key={index}>
                <IonItem className="modalSubTitle">
                  <IonLabel>{audit.changes.createdAt}</IonLabel>
                </IonItem>
                {audit.changes.history.map((change) => {
                  return (
                    <IonItem className="modalInput" key={change}>
                      <p> {change}</p>
                    </IonItem>
                  );
                })}
              </IonGrid>
            );
          })}
        </IonGrid>
      </IonContent>
      <IonFab vertical="top" horizontal="end" slot="fixed">
        <IonFabButton
          color="medium"
          size="small"
          onClick={() => {
            setAudits(undefined);
            onClose();
          }}
        >
          <IonIcon icon={close} />
        </IonFabButton>
      </IonFab>
    </IonModal>
  );
};

export default EditHistoryModal;
