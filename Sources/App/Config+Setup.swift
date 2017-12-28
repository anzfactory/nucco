import LeafProvider
// import MySQLProvider
import PostgreSQLProvider

extension Config {
    public func setup() throws {
        // allow fuzzy conversions for these types
        // (add your own types here)
        Node.fuzzy = [JSON.self, Node.self]

        try setupProviders()
    }

    /// Configure providers
    private func setupProviders() throws {
        try addProvider(LeafProvider.Provider.self)
        
        // try self.addProvider(MySQLProvider.Provider.self)
        try self.addProvider(PostgreSQLProvider.Provider.self)
        self.preparations.append(Question.self)
        self.preparations.append(Answer.self)
    }
}
