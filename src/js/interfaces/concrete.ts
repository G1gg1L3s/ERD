
  type ID = number;

  // Domain
  interface Document {
    id: ID,
  };

  interface Metadata {
    id: ID,
    key: string;
    value: any;
    doc_id: ID;
  };

  interface Tag {
    id: ID,
    value: any;
  };

  interface Link {
    id: ID,
    doc_id: ID,
    tag_id: ID,
  };


  // User profile
  interface User {
    id: ID,
    name: string,
    password: string,
    email: string,
  };


  // History
  interface Event {
    id: ID,
    date: Date,
    user: User,
  };

  interface Extra {
    id: ID,
    key: string;
    value: any;
    event_id: ID;
  };

  // Access Policy
  interface ObjectType {
    id: ID,
    name: string,
  };

  interface OperationType {
    id: ID,
    name: string,
  };

  interface RequestType {
    id: ID,
    name: string,
    operation_id: ID,
    request_id: ID,
  };

  interface Role {
    id: ID,
    name: string,
    description: string | null,
  };

  interface Grant {
    id: ID,
    request_id: ID,
    role_id: ID | null,
    user_id: ID | null,
  };
