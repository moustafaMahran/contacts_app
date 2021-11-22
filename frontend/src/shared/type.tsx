export type Contact = {
  id: number | null;
  firstName: string;
  lastName: string;
  email: string;
  phoneNumber: string;
}

export type EditHistory = {
  changes: EditChange
}

export type EditChange = {
  createdAt: string,
  history: string[]
}