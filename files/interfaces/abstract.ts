  // Domain
  interface Document {};

  interface Metadata {
    key: string;
    value: any;
    doc: Document;
  };

  interface Tag {
    value: any;
  };

  interface Link {
    doc: Document,
    tag: Tag,
  };


  // User profile
  interface User {
    name: string,
    password: string,
    email: string,
  };


  // History
  interface Event {
    date: Date,
    user: User,
  };

  interface Extra {
    key: string;
    value: any;
    event: Event;
  };

  // Access Policy
  interface ObjectType {
    name: string,
  };

  interface OperationType {
    name: string,
  };

  interface RequestType {
    name: string,
    operation: OperationType,
    request: RequestType,
  };

  interface Role {
    name: string,
    description: string,
  };

  interface Grant {
    request: RequestType,
    role: Role | null,
    user: User | null,
  };
