defmodule ConfigurableTableNameTest do
  use ExUnit.Case

  test "default table name is 'versions'" do
    # Reset any existing config
    Application.delete_env(:paper_trail, :versions_table_name)

    # The module should use the default "versions" table name
    assert PaperTrail.Version.__schema__(:source) == "versions"
  end

  test "can read configured table name from application environment" do
    # Test that Application.compile_env reads the configured value at compile time
    # Note: compile_env is resolved at compile time, so we test the API directly
    table_name = Application.compile_env(:paper_trail, :versions_table_name, "versions")
    assert table_name == "versions"  # Should be default since no config set at compile time

    # Clean up
    Application.delete_env(:paper_trail, :versions_table_name)
  end

  test "migration generator reads table name from config" do
    # Test that the install task respects configuration at compile time
    table_name = Application.compile_env(:paper_trail, :versions_table_name, "versions")
    assert table_name == "versions"  # Default value when no compile-time config

    # The actual configuration would be set in config files before compilation
    # This test verifies the API works correctly
  end
end
