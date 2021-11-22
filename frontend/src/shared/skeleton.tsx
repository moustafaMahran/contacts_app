import {
  IonItem,
  IonLabel,
  IonSkeletonText,
  IonList,
  IonGrid,
  IonCol,
  IonRow,
} from "@ionic/react";

export const SkeletonComponent: React.FC = () => {
  const renderSkeleton = () => {
    const size = 2;
    return [...Array(size)].map((e, i) => (
      <IonCol size-sm="6" size-xs="12" key={i}>
        <IonItem lines="none">
          <IonLabel>
            <h2>
              <IonSkeletonText
                animated
                style={{ width: "60%" }}
              ></IonSkeletonText>
            </h2>
            <h3>
              <IonSkeletonText
                animated
                style={{ width: "80%" }}
              ></IonSkeletonText>
            </h3>
            <p>
              <IonSkeletonText
                animated
                style={{ width: "100%" }}
              ></IonSkeletonText>
            </p>
          </IonLabel>
        </IonItem>
      </IonCol>
    ));
  };
  return (
    <IonList id="skeleton">
      <IonGrid>
        <IonRow>{renderSkeleton()}</IonRow>
      </IonGrid>
    </IonList>
  );
};
