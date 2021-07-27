class DesignSystemDocsController < ApplicationController
  def index
    @design_system_docs = OpenStruct.new(
      typography: {
        H1: {
          element: "h1",
          weight: "bold",
          size: "3xl"
        },
        H2: {
          element: "h2",
          weight: "bold",
          size: "2xl"
        },
        H3: {
          element: "h3",
          weight: "bold",
          size: "xl"
        },
        H4: {
          element: "h4",
          weight: "bold",
          size: "sm"
        },
        "Body 1": {
          element: "p",
          weight: "normal",
          size: "lg"
        },
        "Body 2": {
          element: "p",
          weight: "normal",
          size: "base"
        },
        "Body 3": {
          element: "p",
          weight: "semibold",
          size: "xs"
        }
      },
      colors: {
        purple: [
          "purple-100"
        ],
        indigo: %w[
          indigo-200 indigo-300
        ],
        white: [
          "white"
        ],
        gray: %w[
          gray-100 gray-200
        ],
        red: [
          "red-100"
        ],
        blue: [
          "blue-100"
        ]
      }
    )
  end
end
