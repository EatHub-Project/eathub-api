defmodule Eathub.AssetStore do
  @moduledoc """
  Responsible for accepting files and uploading them to an asset store.
  """
  @moduledoc """
  Responsible for accepting files and uploading them to an asset store.
  """

  import SweetXml
  alias ExAws.S3

  @doc """
  Accepts a Plug.Upload and uploads it to S3.

  ## Examples

      iex> upload_image(...)
      "https://image_bucket.s3.amazonaws.com/dbaaee81609747ba82bea2453cc33b83.png"

  """
  @spec upload_image(String.t) :: s3_url :: String.t
  def upload_image(file) do
    # Get the file's extension
    file_extension = Path.extname(file.filename)

    # Generate the UUID
    file_uuid = UUID.uuid4(:hex)

    # Set the S3 filename
    s3_filename = "#{file_uuid}#{file_extension}"

    # The S3 bucket to upload to
    s3_bucket = System.get_env("BUCKET_NAME")

    # Load the file into memory
    {:ok, file_binary} = File.read(file.path)

    # Upload the file to S3
    image_response =
      ExAws.S3.put_object(s3_bucket, s3_filename, file_binary)
      |> ExAws.request!

    "https://#{s3_bucket}.s3.amazonaws.com/#{s3_bucket}/#{s3_filename}"
  end
end
